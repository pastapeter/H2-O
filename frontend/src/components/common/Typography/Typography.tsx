import { css } from '@emotion/react';
import styled from '@emotion/styled';
import type { SpaceStyle } from '@/types/boxStyle';
import type { Colors } from '@/styles/colors';
import type { TypographyVariant } from '@/styles/typography';

interface TypographyProps {
  font?: TypographyVariant;
  color?: Colors;
}

type Props = TypographyProps & SpaceStyle;

const Typography = styled.p<Props>`
  ${({
    theme,
    font,
    color,
    marginBottom,
    marginLeft,
    marginRight,
    marginTop,
    paddingBottom,
    paddingLeft,
    paddingRight,
    paddingTop,
  }) => {
    return css`
      color: ${color && theme.colors[color]};
      ${font && theme.typography[font]}
      ${{
        marginBottom,
        marginLeft,
        marginRight,
        marginTop,
        paddingBottom,
        paddingLeft,
        paddingRight,
        paddingTop,
      }}
    `;
  }}
`;

export default Typography;
