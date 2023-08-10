import type { HTMLAttributes, PropsWithChildren } from 'react';
import styled from '@emotion/styled';
import { replaceToRealNewLine } from '@/utils/string';

interface Props extends HTMLAttributes<HTMLDivElement> {
  title: string;
  subTitle: string;
  description?: string;
  isTitleColorWhite?: boolean;
  backgroundColor?: string;
}

function Banner({
  children,
  title,
  subTitle,
  description,
  isTitleColorWhite = false,
  backgroundColor,
  ...restProps
}: PropsWithChildren<Props>) {
  return (
    <BannerContainer backgroundColor={backgroundColor} {...restProps}>
      <div>
        <TitleContainer isTitleColorWhite={isTitleColorWhite}>
          <h3>{subTitle}</h3>
          <h2>{title}</h2>
          {description && <Description>{replaceToRealNewLine(description)}</Description>}
        </TitleContainer>
        {children}
      </div>
    </BannerContainer>
  );
}

export default Banner;

const BannerContainer = styled.div<Pick<Props, 'backgroundColor'>>`
  position: relative;
  width: 100%;
  height: 360px;
  background: ${({ backgroundColor }) => backgroundColor};
  box-shadow: 0px 0px 8px 0px rgba(131, 133, 136, 0.2);

  & > div {
    position: relative;
    ${({ theme }) => theme.flex.flexBetweenRow}
    max-width: 1024px;
    width: 100%;
    height: 100%;
    margin: 0 auto;
  }
`;

const TitleContainer = styled.div<Pick<Props, 'isTitleColorWhite'>>`
  position: fixed;
  width: 234px;
  top: 72px;
  display: flex;
  flex-direction: column;
  gap: 4px;

  h3 {
    ${({ theme }) => theme.typography.TextKRRegular14}
    color: ${({ isTitleColorWhite, theme }) => (isTitleColorWhite ? 'white' : theme.colors.gray900)};
  }

  h2 {
    ${({ theme }) => theme.typography.HeadKRBold32}
    color: ${({ isTitleColorWhite, theme }) => (isTitleColorWhite ? 'white' : theme.colors.primary700)};
  }
`;

const Description = styled.p`
  ${({ theme }) => theme.typography.TextKRRegular12}
  width: 207px;
  white-space: pre-line;
  word-break: keep-all;
  margin-bottom: 24px;
`;
