import type { PropsWithChildren } from 'react';
import styled from '@emotion/styled';
import { css } from '@emotion/react';

type TabState = 'active' | 'inactive' | 'complete';

interface Props {
  state?: TabState;
}

function Tab({ children, state = 'inactive' }: PropsWithChildren<Props>) {
  return <StyledTab state={state}>{children}</StyledTab>;
}

export default Tab;

const StyledTab = styled.button<Pick<Props, 'state'>>`
  display: flex;
  justify-content: center;
  width: 52px;
  height: 100%;
  position: relative;
  background-color: transparent;

  ${({ state, theme }) => {
    switch (state) {
      case 'active':
        return css`
          ${theme.typography.HeadKRMedium14};
          color: ${theme.colors.primary500};

          &::after {
            position: absolute;
            bottom: 0;
            content: '';
            width: 18px;
            height: 2px;
            background-color: ${theme.colors.primary500};
          }
        `;
      case 'complete':
        return css`
          color: ${theme.colors.primary200};
        `;
    }
  }}
`;
