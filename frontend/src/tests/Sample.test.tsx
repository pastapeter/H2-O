import { render, screen } from '@/tests/test-util';
import { CTAButton } from '@/components/common';

describe('Sample', () => {
  it('renders CTAButton', () => {
    render(<CTAButton>버튼</CTAButton>);
    const text = screen.getByText(/버튼/i);
    expect(text).toBeInTheDocument();
  });
});
