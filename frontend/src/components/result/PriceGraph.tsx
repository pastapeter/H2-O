import { Fragment, useEffect, useRef } from 'react';
import { useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { getTrimPriceDistribution } from '@/apis/trim';
import { Flex, Loading } from '@/components/common';
import { getCurrentPricePoint, getPathLAttribute } from '@/components/result/utils/graph';
import { useFetcher, useSafeContext } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import { SelectionContext } from '@/providers/SelectionProvider';

function PriceGraph() {
  const { selectionInfo, totalPrice } = useSafeContext(SelectionContext);
  const { colors } = useTheme();
  const containerRef = useRef<HTMLDivElement | null>(null);
  const svgRef = useRef<SVGSVGElement | null>(null);
  const pathRef = useRef<SVGPathElement | null>(null);
  const markerRef = useRef<HTMLDivElement | null>(null);

  const trimId = selectionInfo.trim?.id;

  const { isLoading, data: priceData } = useFetcher({
    fetchFn: () => getTrimPriceDistribution(trimId as number),
    enabled: !!trimId,
  });

  useEffect(() => {
    if (!priceData) return;
    if (!containerRef.current || !svgRef.current || !pathRef.current) return;
    const { width: SVGWidth, height: SVGHeight } = containerRef.current.getBoundingClientRect();

    const d = getPathLAttribute(priceData.quantityPerUnit, containerRef.current);

    const svg = svgRef.current;
    const path = pathRef.current;

    svg.setAttribute('viewbox', `0 0 ${SVGWidth} ${SVGHeight}`);
    svg.setAttribute('height', `${SVGHeight + 5}`);
    path.setAttribute('d', d);

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [containerRef.current, containerRef.current, priceData]);

  useEffect(() => {
    if (!markerRef.current || !containerRef.current) return;
    if (!priceData || !selectionInfo.priceRange) return;

    const currentPoint = getCurrentPricePoint({
      data: priceData.quantityPerUnit,
      unit: priceData.unit,
      currentPrice: totalPrice,
      minPrice: selectionInfo.priceRange.minPrice,
      maxPrice: selectionInfo.priceRange.maxPrice,
      element: containerRef.current,
    });

    markerRef.current.style.setProperty('left', `${currentPoint.x}px`);
    markerRef.current.style.setProperty('bottom', `${currentPoint.y}px`);
  }, [totalPrice, priceData, selectionInfo]);

  if (!selectionInfo.priceRange) return <Loading />;

  const { minPrice, maxPrice } = selectionInfo.priceRange;

  return (
    <Fragment>
      <Container ref={containerRef}>
        {isLoading ? (
          <Loading />
        ) : (
          <Fragment>
            <svg ref={svgRef} xmlns='http://www.w3.org/2000/svg' width='100%' transform='scale(1, -1)'>
              <path ref={pathRef} fill='none' stroke={colors.gray200} strokeWidth='4' />
            </svg>
            <Circle ref={markerRef} />
          </Fragment>
        )}
      </Container>
      <Flex justifyContent='space-between' marginTop={20}>
        <PriceContainer flexDirection='column'>
          <span className='label'>최소</span>
          <span className='price'>{`${toSeparatedNumberFormat(minPrice)}원`}</span>
        </PriceContainer>
        <PriceContainer flexDirection='column' alignItems='flex-end'>
          <span className='label'>최대</span>
          <span className='price'>{`${toSeparatedNumberFormat(maxPrice)}원`}</span>
        </PriceContainer>
      </Flex>
    </Fragment>
  );
}

export default PriceGraph;

const Container = styled.div`
  position: relative;
  width: 100%;
  height: 120px;
  margin-top: 40px;
`;

const PriceContainer = styled(Flex)`
  color: ${({ theme }) => theme.colors.gray600};

  .label {
    ${({ theme }) => theme.typography.HeadKRMedium16}
  }
  .price {
    ${({ theme }) => theme.typography.TextKRRegular16}
  }
`;

const Circle = styled.div`
  position: absolute;
  width: 22px;
  height: 22px;
  transform: translate(-50%, calc(50% + 11px));
  border-radius: 50%;
  border: 2px solid ${({ theme }) => theme.colors.activeBlue2};

  &::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background-color: ${({ theme }) => theme.colors.activeBlue2};
  }

  &::after {
    content: '내 견적';
    position: absolute;
    left: 100%;
    top: 50%;
    transform: translate(10px, -50%);
    color: ${({ theme }) => theme.colors.activeBlue2};
    white-space: nowrap;
  }
`;
