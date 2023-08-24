import styled from '@emotion/styled';

const HashTag = styled.div`
  ${({ theme }) => theme.typography.TextKRRegular12}
  background-color: ${({ theme }) => theme.colors.hashTagBg};
  color: ${({ theme }) => theme.colors.gray50};
  display: flex;
  align-items: center;
  padding: 2px 6px;
  border-radius: 2px;
`;

export default HashTag;
