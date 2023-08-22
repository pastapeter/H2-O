import styled from '@emotion/styled';
import { Flex, Typography } from '@/components/common';

interface Props {
  isQuotation?: boolean;
  height: number;
  salesCount: number;
}

function SalesBar({ isQuotation = true, height, salesCount }: Props) {
  return (
    <Flex flexDirection='column' alignItems='center'>
      <Typography font='TextKRMedium14' color={isQuotation ? 'gray300' : 'activeBlue2'}>
        {salesCount}대
      </Typography>
      <Bar isQuotation={isQuotation} height={height} />
      <Typography font='HeadKRMedium14' color={isQuotation ? 'gray300' : 'activeBlue2'}>
        {isQuotation ? '유사견적' : '내 견적'}
      </Typography>
    </Flex>
  );
}

export default SalesBar;

const Bar = styled.div<Omit<Props, 'salesCount'>>`
  background-color: ${({ theme, isQuotation }) => (isQuotation ? theme.colors.gray200 : theme.colors.activeBlue2)};
  height: ${({ height }) => height}px;
  width: 14px;
  margin: 4px 0px 7px 0px;
`;
