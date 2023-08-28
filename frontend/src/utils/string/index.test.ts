import { replaceToRealNewLine, toPriceFormatString } from '@/utils/string';

describe('toPriceFormatString 유틸 함수 테스트', () => {
  it('0 이상일 경우 +를 붙여서 반환한다.', () => {
    const price = 1000;
    const result = toPriceFormatString(price);

    expect(result).toBe('+1,000');
  });

  it('음수일 경우 -를 붙여서 반환한다.', () => {
    const price = -1000;
    const result = toPriceFormatString(price);

    expect(result).toBe('-1,000');
  });
});

describe('replaceToRealNewLine 유틸함수 테스트', () => {
  it('replaceToRealNewLine이 값을 반환한다.', () => {
    const input = 'test\\n';

    const result = replaceToRealNewLine(input);
    expect(result).toBeTruthy();
  });

  it('replaceToRealNewLine이 문자열을 반환한다.', () => {
    const input = 'test\\n';

    const result = replaceToRealNewLine(input);
    expect(result).toBeTypeOf('string');
  });

  it('문자열에 있는 \\n 문자를 실제 개행으로 바꾼다.', () => {
    const input = 'test\\n test \\n';

    const result = replaceToRealNewLine(input);
    expect(result).toBe('test\n test \n');
  });
});
