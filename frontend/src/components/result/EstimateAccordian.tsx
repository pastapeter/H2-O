import { type HTMLAttributes, type MouseEventHandler, useCallback, useEffect, useRef, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { Flex, Icon, Typography } from '@/components/common';
import { toPriceFormatString } from '@/utils/string';

interface EstimateAccordianProps extends HTMLAttributes<HTMLDivElement> {
  label: string;
  totalPrice?: number;
  description?: string;
  isExpanded?: boolean;
}

interface DetailProps {
  type?: string;
  colorCode?: string;
  thumbnail?: string;
  name: string;
  price: number;
  isModify?: boolean;
  handleClickButton: () => void;
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
  }, [detailRef.current, children]);

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
            <Typography font='HeadKRMedium14' color='primary500'>{`${toPriceFormatString(totalPrice)}원`}</Typography>
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

function Detail({ thumbnail, colorCode, type, name, price, isModify = true, handleClickButton }: DetailProps) {
  return (
    <DetailContainer>
      <Flex width='100%' height='55px' gap={16}>
        <ImageContainer colorCode={colorCode}>
          {thumbnail && <Thumbnail src={thumbnail} alt='선택사항 썸네일 이미지' />}
        </ImageContainer>
        <Flex justifyContent='space-between' alignItems='center' width='100%'>
          <Flex flexDirection='column' height='100%' gap={10}>
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
            <ModifyButton isModify={isModify} onClick={handleClickButton}>
              {isModify ? '수정하기' : '삭제하기'}
            </ModifyButton>
            <Typography font='TextKRRegular14' color='gray900'>{`${toPriceFormatString(price)}원`}</Typography>
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

const ImageContainer = styled.div<Pick<DetailProps, 'colorCode'>>`
  width: 77px;
  height: 100%;
  border-radius: 2px;
  overflow: hidden;
  background-color: ${({ colorCode }) => colorCode};
  flex-shrink: 0;
`;

const Thumbnail = styled.img`
  width: 100%;
  height: 100%;
  object-fit: cover;
`;

const ModifyButton = styled.button<{ isModify: boolean }>`
  ${({ theme }) => theme.typography.HeadKRMedium14}
  color: ${({ theme, isModify }) => (isModify ? theme.colors.primary500 : theme.colors.sand)}
`;
