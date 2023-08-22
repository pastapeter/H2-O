import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { OptionCard } from './utils';
import type { QutationResponse } from '@/types/interface';
import { Flex, HMGTag, HashTag, Icon, Typography } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import { toPriceFormatString } from '@/utils/string';
import { SelectionContext, SelectionInfoWithImage } from '@/providers/SelectionProvider';

const estimationOrder = ['첫번째', '두번째', '세번째', '네번째'];

interface Props {
  prevPage: () => void;
  nextPage: () => void;
  cardIdx: number;
  isActive: boolean;
  isStartPage: boolean;
  isLastPage: boolean;
  estimation: QutationResponse;
  addData: (data: SelectionInfoWithImage) => void;
  removeData: (data: SelectionInfoWithImage) => void;
  hasData: (data: SelectionInfoWithImage) => boolean;
}

function EstimationCard({
  prevPage,
  nextPage,
  cardIdx,
  isActive,
  isStartPage,
  isLastPage,
  estimation,
  addData,
  removeData,
  hasData,
}: Props) {
  const { totalPrice } = useSafeContext(SelectionContext);

  const handleClickOptionCard = (option: SelectionInfoWithImage) => () => {
    hasData(option) ? removeData(option) : addData(option);
  };

  return (
    <CardContainer>
      <Flex height='100%' paddingTop={48} paddingLeft={40} gap={20}>
        <Icon iconType='ArrowLeft' css={StyleIcon(isActive && !isStartPage, false)} onClick={prevPage} />
        <Flex flexDirection='column' justifyContent='space-between' paddingBottom={52}>
          <Flex flexDirection='column'>
            <Typography font='TextKRRegular10' color='gray900'>
              {estimationOrder[cardIdx]} 유사견적서
            </Typography>
            <Typography font='HeadKRBold18' color='primary700'>
              Le Blanc
            </Typography>
          </Flex>
          <Flex gap={5}>
            <HashTag title={estimation.modelType.bodytypeName} />
            <HashTag title={estimation.modelType.drivetrainName} />
            <HashTag title={estimation.modelType.powertrainName} />
          </Flex>
          <Flex flexDirection='column'>
            <Typography font='HeadKRMedium14' color='primary700'>
              {toSeparatedNumberFormat(estimation.price)}원
            </Typography>
            <Typography font='TextKRRegular10' color='sand'>
              {toPriceFormatString(estimation.price - totalPrice)}원
            </Typography>
          </Flex>
        </Flex>
        <StlyedImg src={estimation.image} />
      </Flex>
      <HMGInfo flexDirection='column' gap={10}>
        <HMGTag />
        <Flex flexDirection='column' paddingLeft={16} gap={4}>
          <Typography font='TextKRMedium10' color='gray900'>
            내 견적에는 없는 옵션이에요.
          </Typography>
          <Flex gap={8}>
            {estimation.options.map((opt) => (
              <OptionCard key={opt.id} option={opt} isClicked={hasData(opt)} onClick={handleClickOptionCard(opt)} />
            ))}
          </Flex>
        </Flex>
        <Icon iconType='ArrowRight' css={StyleIcon(isActive && !isLastPage, true)} onClick={nextPage} />
      </HMGInfo>
    </CardContainer>
  );
}

export default EstimationCard;

const CardContainer = styled.div`
  ${({ theme }) => theme.flex.flexBetweenRow}
  position: relative;
  align-items: center;
  border-radius: 2px;
  border: 1px solid ${({ theme }) => theme.colors.skyBlue};
  background: ${({ theme }) => theme.colors.white};
  width: 762px;
  height: 224px;
  flex-shrink: 0;
`;

const StyleIcon = (isActive: boolean, isRight: boolean) => {
  const theme = useTheme();
  return css`
    position: absolute;
    top: 50%;
    transform: translateY(${isRight ? '-50%' : '50%'});
    rotate: ${!isRight && '180deg'};
    left: ${!isRight && `0px`};
    right: ${isRight && `0px`};
    fill: ${isActive ? theme.colors.gray600 : theme.colors.gray200};
    cursor: ${isActive && 'pointer'};
    pointer-events: ${!isActive && 'none'};
  `;
};

const StlyedImg = styled.img`
  width: 274px;
  height: 156px;
`;

const HMGInfo = styled(Flex)`
  background-color: ${({ theme }) => theme.colors.gray50};
  width: 275px;
  height: 100%;
  padding-top: 29px;
`;
