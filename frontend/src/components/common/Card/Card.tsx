import styled from '@emotion/styled';

interface Props {
  isSelected?: boolean;
}

const Card = styled.div<Props>`
  border: 1px solid ${({ isSelected, theme }) => (isSelected ? theme.colors.activeBlue : theme.colors.gray200)};
  background-color: ${({ isSelected, theme }) => (isSelected ? theme.colors.cardBg : 'white')};
  color: ${({ isSelected, theme }) => (isSelected ? theme.colors.gray900 : theme.colors.gray500)};

  &:hover {
    border-color: ${({ theme }) => theme.colors.activeBlue};
  }
`;

export default Card;
