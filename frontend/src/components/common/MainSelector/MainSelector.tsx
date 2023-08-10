import type { HTMLAttributes, PropsWithChildren } from 'react';
import styled from '@emotion/styled';

interface Props extends HTMLAttributes<HTMLDivElement> {
  title: string;
}

function MainSelector({ children, title }: PropsWithChildren<Props>) {
  return (
    <MainSelectorContainer>
      <div>
        <h2>{title}</h2>
        {children}
      </div>
    </MainSelectorContainer>
  );
}

export default MainSelector;

const MainSelectorContainer = styled.div`
  position: relative;
  width: 100%;
  min-height: calc(100vh - 420px);
  padding-top: 16px;
  background-color: ${({ theme }) => theme.colors.white};
  filter: drop-shadow(0px 0px 8px rgba(131, 133, 136, 0.2));

  & > div {
    max-width: 1024px;
    width: 100%;
    margin: 0 auto;
  }

  h2 {
    ${({ theme }) => theme.typography.HeadKRMedium16}
    color: ${({ theme }) => theme.colors.gray900};
    margin-bottom: 12px;
  }
`;
