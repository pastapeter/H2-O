import type { HTMLAttributes, PropsWithChildren } from 'react';
import styled from '@emotion/styled';
import { Flex, Typography } from '@/components/common';

interface Props extends HTMLAttributes<HTMLDivElement> {
  title?: string;
  subTitle?: string;
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
    <BannerContainer role='banner' backgroundColor={backgroundColor} {...restProps}>
      <Flex justifyContent='space-between' width='100%' height='100%'>
        {title && (
          <TitleContainer flexDirection='column' gap={4} isTitleColorWhite={isTitleColorWhite}>
            <h3>{subTitle}</h3>
            <h2>{title}</h2>
            {description && <Description font='TextKRRegular14'>{description}</Description>}
          </TitleContainer>
        )}
        {children}
      </Flex>
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
    max-width: 1024px;
    margin: 0 auto;
  }
`;

const TitleContainer = styled(Flex)<Pick<Props, 'isTitleColorWhite'>>`
  position: fixed;
  top: 72px;
  width: 400px;

  & > h3 {
    ${({ theme }) => theme.typography.TextKRRegular14}
    color: ${({ isTitleColorWhite, theme }) => (isTitleColorWhite ? 'white' : theme.colors.gray900)};
  }

  & > h2 {
    ${({ theme }) => theme.typography.HeadKRBold32}
    color: ${({ isTitleColorWhite, theme }) => (isTitleColorWhite ? 'white' : theme.colors.primary700)};
  }
`;

const Description = styled(Typography)`
  width: 100%;
  word-break: keep-all;
  margin-bottom: 24px;
`;
