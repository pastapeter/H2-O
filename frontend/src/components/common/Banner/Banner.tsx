import type { HTMLAttributes, PropsWithChildren } from 'react';
import styled from '@emotion/styled';

interface Props extends HTMLAttributes<HTMLDivElement> {
  title: string;
  subTitle: string;
  isTitleColorWhite?: boolean;
}

function Banner({ children, title, subTitle, isTitleColorWhite = false, ...restProps }: PropsWithChildren<Props>) {
  return (
    <BannerContainer {...restProps}>
      <div>
        <TitleContainer isTitleColorWhite={isTitleColorWhite}>
          <p>{subTitle}</p>
          <h2>{title}</h2>
        </TitleContainer>
        {children}
      </div>
    </BannerContainer>
  );
}

export default Banner;

const BannerContainer = styled.div`
  position: relative;
  width: 100%;
  height: 360px;
  background: linear-gradient(180deg, rgba(162, 199, 231, 0.2) 24.92%, rgba(255, 255, 255, 0) 61.36%), #fff;
  box-shadow: 0px 0px 8px 0px rgba(131, 133, 136, 0.2);

  & > div {
    ${({ theme }) => theme.flex.flexBetweenRow}
    max-width: 1024px;
    width: 100%;
    margin: 0 auto;
  }
`;

const TitleContainer = styled.div<Pick<Props, 'isTitleColorWhite'>>`
  position: fixed;
  top: 72px;
  display: flex;
  flex-direction: column;
  gap: 4px;

  p {
    ${({ theme }) => theme.typography.TextKRRegular14}
    color: ${({ isTitleColorWhite, theme }) => (isTitleColorWhite ? 'white' : theme.colors.gray900)};
  }

  h2 {
    ${({ theme }) => theme.typography.HeadKRBold32}
    color: ${({ isTitleColorWhite, theme }) => (isTitleColorWhite ? 'white' : theme.colors.primary700)};
  }
`;
