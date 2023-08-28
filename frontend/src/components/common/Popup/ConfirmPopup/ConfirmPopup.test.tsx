import ConfirmPopup from './ConfirmPopup';
import { fireEvent, render, screen } from '@/tests/test-util';

describe('Confirm Popup 컴포넌트 테스트', () => {
  beforeEach(() => {
    const portalRoot = global.document.createElement('div');
    portalRoot.setAttribute('id', 'portal-root');

    const body = global.document.querySelector('body');
    if (!body) throw new Error('portal-root의 body를 찾을 수 없습니다.');
    body.appendChild(portalRoot);
  });

  const props = {
    hasCancelButton: true,
    confirmButtonLabel: '확인',
    handleClickCancelButton: vi.fn(),
    handleClickConfirmButton: vi.fn(),
  };

  it('ConfirmPopup 컴포넌트가 팝업에 정상적으로 렌더링 된다.', () => {
    render(<ConfirmPopup {...props} />);

    expect(screen.getByTestId('dimmed')).toBeInTheDocument();
    expect(screen.getByRole('dialog')).toBeInTheDocument();
    expect(screen.getByTestId('confirm-modal')).toBeInTheDocument();
  });

  it('ConfirmPopup 컴포넌트의 children이 정상적으로 렌더링된다.', () => {
    render(<ConfirmPopup {...props}>Hello World</ConfirmPopup>);

    expect(screen.getByText('Hello World')).toBeInTheDocument();
  });

  it('컴포넌트의 프로퍼티 중 hasCancelButton이 true이면 버튼이 두 개 렌더링된다.', () => {
    render(<ConfirmPopup {...props} />);

    const buttons = screen.getAllByRole('button');
    expect(buttons).toHaveLength(2);
  });

  it('컴포넌트의 프로퍼티 중 hasCancelButton이 false이면 버튼이 한 개 렌더링된다.', () => {
    const newProps = { ...props, hasCancelButton: false };
    render(<ConfirmPopup {...newProps} />);

    const buttons = screen.getAllByRole('button');
    expect(buttons.length).toBe(1);
  });

  it('컴포넌트의 프로퍼티 중 cancelButtonLabel의 default값은 취소이다.', () => {
    render(<ConfirmPopup {...props} />);

    const buttons = screen.getAllByRole('button');
    expect(buttons[0].innerHTML).toBe('취소');
  });

  it('컴포넌트의 프로퍼티 중 cancelButtonLabel과 confirmButtonLabel을 통해서 버튼의 이름을 정할 수 있다.', () => {
    const newProps = { ...props, cancelButtonLabel: '종료', confirmButtonLabel: '확인' };
    render(<ConfirmPopup {...newProps} />);

    const buttons = screen.getAllByRole('button');
    expect(buttons[0].innerHTML).toBe('종료');
    expect(buttons[1].innerHTML).toBe('확인');
  });

  it('컴포넌트의 cancelButton을 클릭할 경우 handleClickCancelButton이 실행된다.', () => {
    const newProps = { ...props, handleClickCancelButton: vi.fn() };
    render(<ConfirmPopup {...newProps} />);

    const cancelButton = screen.getByText('취소');
    fireEvent.click(cancelButton);

    expect(newProps.handleClickCancelButton).toBeCalledTimes(1);
  });

  it('컴포넌트의 confirmButton을 클릭할 경우 handleClickConfirmButton이 실행된다.', () => {
    const newProps = { ...props, handleClickConfirmButton: vi.fn() };
    render(<ConfirmPopup {...newProps} />);

    const confirmButton = screen.getByText(props.confirmButtonLabel);
    fireEvent.click(confirmButton);

    expect(newProps.handleClickConfirmButton).toBeCalledTimes(1);
  });

  it('dimmed영역을 클릭할 경우 handleClickCancel이 실행된다.', () => {
    const newProps = { ...props, handleClickCancelButton: vi.fn() };
    render(<ConfirmPopup {...newProps} />);

    const dimmed = screen.getByTestId('dimmed');
    fireEvent.click(dimmed);

    expect(newProps.handleClickCancelButton).toBeCalledTimes(1);
  });

  it('ConfirmPopup 컴포넌트 스냅샷 테스트', () => {
    render(<ConfirmPopup {...props}>Snapshot</ConfirmPopup>);

    expect(screen.getByTestId('confirm-modal')).toMatchSnapshot();
  });
});
