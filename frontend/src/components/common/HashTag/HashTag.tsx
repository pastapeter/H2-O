import styled from '@emotion/styled';

const HashTag = styled.div(
  {
    display: 'flex',
    alignItems: 'center',
    padding: '2px 6px',
    borderRadius: '2px',
  },
  ({ theme }) => ({
    ...theme.typography.TextKRRegular12,
    backgroundColor: theme.colors.hashTagBg,
    color: theme.colors.gray50,
  }),
);

export default HashTag;
