import styled from '@emotion/styled';
import { Typography } from '@/components/common';

interface Props {
  title: string;
}
function HashTag({ title }: Props) {
  return (
    <StyleHashTag as='span' font='TextKRRegular12' color='gray50'>
      {title}
    </StyleHashTag>
  );
}

export default HashTag;

const StyleHashTag = styled(Typography)`
  align-items: center;
  background-color: ${({ theme }) => theme.colors.hashTagBg};
  border-radius: 2px;
  padding: 2px 6px;
  width: fit-content;
  height: fit-content;
`;
