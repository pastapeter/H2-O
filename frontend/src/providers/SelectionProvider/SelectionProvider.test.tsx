import { Fragment, useContext } from 'react';
import { render, waitFor } from '@testing-library/react';
import SelectionProvider, { SelectionContext } from './SelectionProvider';
import { screen, userEvent } from '@/tests/test-util';

const Child = () => {
  const context = useContext(SelectionContext);
  if (!context) throw new Error('SelectionContext is null');

  const { selectionInfo, totalPrice, dispatch } = context;

  const handleClick = () => {
    dispatch({
      type: 'SET_TRIM',
      payload: {
        id: 1,
        name: 'palisade',
        price: 1000,
      },
    });
  };

  const trim = selectionInfo.trim;

  return (
    <Fragment>
      <span data-testid='total-price'>{totalPrice}</span>
      <span data-testid='trim-name'>{trim ? trim.name : 'not yet'}</span>
      <button onClick={handleClick}>버튼</button>
    </Fragment>
  );
};

const renderComponentWithProvider = () => {
  render(<Child />, {
    wrapper: SelectionProvider,
  });
};

describe('SelectionProvider 테스트', () => {
  it('SelectionProvider가 children 컴포넌트를 정상적으로 렌더링 한다.', () => {
    renderComponentWithProvider();

    expect(screen.getByTestId('total-price')).toBeInTheDocument();
    expect(screen.getByTestId('trim-name')).toBeInTheDocument();
    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it('SelectionProvider의 children 컴포넌트가 context의 totalPrice값을 정상적으로 참조한다.', () => {
    renderComponentWithProvider();

    expect(screen.getByTestId('total-price')).toHaveTextContent('0');
  });

  it('SelectionProvider의 children 컴포넌트가 dispatch를 정상적으로 사용할 수 있다.', async () => {
    renderComponentWithProvider();

    const button = screen.getByRole('button');
    userEvent.click(button);

    await waitFor(() => expect(screen.getByTestId('trim-name')).toHaveTextContent('palisade'));
  });
});
