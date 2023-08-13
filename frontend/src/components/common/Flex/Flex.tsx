import type { HTMLAttributes } from 'react';
import styled from '@emotion/styled';
import type { BoxStyle, BoxStyleProperties } from '@/types/boxStyle';
import type { FlexStyle, FlexStyleProperties } from '@/types/flexStyle';
import type { PositionStyle, PositionStyleProperties } from '@/types/positionStyle';

type Props = FlexStyle & BoxStyle & PositionStyle & HTMLAttributes<HTMLDivElement>;

const componentStyle = ({
  flexDirection,
  justifyContent,
  alignContent,
  alignItems,
  flexWrap,
  gap,
  position,
  top,
  bottom,
  left,
  right,
  backgroundColor,
  width,
  height,
  marginBottom,
  marginLeft,
  marginRight,
  marginTop,
  paddingBottom,
  paddingLeft,
  paddingRight,
  paddingTop,
}: Pick<Props, FlexStyleProperties | BoxStyleProperties | PositionStyleProperties>) => {
  return {
    display: 'flex',
    flexDirection,
    justifyContent,
    alignContent,
    alignItems,
    flexWrap,
    gap,
    position,
    top,
    bottom,
    left,
    right,
    backgroundColor,
    width,
    height,
    marginBottom,
    marginLeft,
    marginRight,
    marginTop,
    paddingBottom,
    paddingLeft,
    paddingRight,
    paddingTop,
  };
};

const Flex = styled.div<Props>((props) => {
  return componentStyle(props);
});

export default Flex;
