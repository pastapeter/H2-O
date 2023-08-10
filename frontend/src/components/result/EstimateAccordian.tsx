import { type HTMLAttributes, type MouseEventHandler, useCallback, useEffect, useRef, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { Flex, Icon, Typography } from '@/components/common';
import { toSeparatedNumberFormat } from '@/utils/number';

interface EstimateAccordianProps extends HTMLAttributes<HTMLDivElement> {
  label: string;
  totalPrice?: number;
  description?: string;
  isExpanded?: boolean;
}

interface DetailProps {
  thumbnail: string;
  type?: string;
  name: string;
  price: number;
}

function EstimateAccordian({
  children,
  label,
  totalPrice,
  description,
  isExpanded: isExpandedFromProps = false,
  ...restProps
}: EstimateAccordianProps) {
  const { colors } = useTheme();

  const [isExpanded, setIsExpanded] = useState(isExpandedFromProps);
  const expandableRef = useRef<HTMLDivElement | null>(null);
  const detailRef = useRef<HTMLDivElement | null>(null);

  const isValidNumber = totalPrice || totalPrice === 0;

  const handleClickToggle: MouseEventHandler<SVGSVGElement> = useCallback(() => {
    if (!expandableRef.current || !detailRef.current) return;

    if (isExpanded) {
      expandableRef.current.style.height = '0px';
    } else {
      expandableRef.current.style.height = `${detailRef.current.clientHeight}px`;
    }

    setIsExpanded((prev) => !prev);
  }, [isExpanded]);

  useEffect(() => {
    if (!isExpanded) return;
    if (!expandableRef.current || !detailRef.current) return;

    expandableRef.current.style.height = `${detailRef.current.clientHeight}px`;
  }, []);

  return (
    <Flex flexDirection='column' width='607px'>
      <SummaryContainer justifyContent='space-between' alignItems='center' {...restProps}>
        <Typography font='HeadKRMedium16' color='gray900'>
          {label}
        </Typography>
        <Flex gap={20} alignItems='center'>
          {description && (
            <Typography font='HeadKRMedium14' color='primary500'>
              {description}
            </Typography>
          )}
          {isValidNumber && (
            <Typography font='HeadKRMedium14' color='primary500'>{`+${toSeparatedNumberFormat(
              totalPrice,
            )}`}</Typography>
          )}
          <Icon
            css={css`
              cursor: pointer;
              transform: ${isExpanded ? 'rotate(-180deg)' : 'rotate(0deg)'};
              transition: transform 0.5s ease;
            `}
            iconType='ArrowDown'
            fill={colors.gray900}
            onClick={handleClickToggle}
          />
        </Flex>
      </SummaryContainer>
      <Expandable ref={expandableRef} flexDirection='column' width='100%'>
        <Flex ref={detailRef} flexDirection='column' width='100%'>
          {children}
        </Flex>
      </Expandable>
    </Flex>
  );
}

function Detail({ thumbnail, type, name, price }: DetailProps) {
  return (
    <DetailContainer>
      <Flex width='100%' height='55px' gap={16}>
        <Thumbnail src={thumbnail} alt='외장 이미지' />
        <Flex justifyContent='space-between' alignItems='center' width='100%'>
          <Flex flexDirection='column' gap={10}>
            {type && (
              <Typography font='TextKRRegular14' color='gray500'>
                {type}
              </Typography>
            )}
            <Typography font='TextKRRegular14' color='gray900'>
              {name}
            </Typography>
          </Flex>
          <Flex flexDirection='column' alignItems='flex-end' gap={10}>
            <Typography font='HeadKRMedium14' color='primary500'>
              수정하기
            </Typography>
            <Typography font='TextKRRegular14' color='gray900'>{`+${toSeparatedNumberFormat(price)}`}</Typography>
          </Flex>
        </Flex>
      </Flex>
    </DetailContainer>
  );
}

EstimateAccordian.Detail = Detail;
export default EstimateAccordian;

const SummaryContainer = styled(Flex)`
  background-color: ${({ theme }) => theme.colors.blueBg};
  width: 100%;
  padding: 12px 20px;
`;

const Expandable = styled(Flex)`
  height: 0px;
  overflow: hidden;
  transition: height 0.5s ease;
`;

const DetailContainer = styled.div`
  height: 70px;
  width: 100%;
  padding: 8px 0px;

  & + & {
    border-top: 1px solid ${({ theme }) => theme.colors.blueBg};
  }
`;

const Thumbnail = styled.img`
  width: 77px;
  height: 100%;
  object-fit: cover;
`;
