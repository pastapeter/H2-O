import { getPriceSum } from './getPriceSum';
import type { SelectionInfoWithImage } from '@/providers/SelectionProvider';

describe('getPriceSum 유틸 테스트', () => {
  function createMockSelections(): SelectionInfoWithImage[] {
    return [
      {
        id: 1,
        name: 'mock1',
        price: 200,
        image: '',
      },
      {
        id: 2,
        name: 'mock2',
        price: 300,
        image: '',
      },
      {
        id: 3,
        name: 'mock3',
        price: 400,
        image: '',
      },
    ];
  }

  it('getPriceSum 함수는 주어진 배열의 price를 모두 더한 값을 반환한다.', () => {
    const selections = createMockSelections();
    const result = getPriceSum(...selections);

    expect(result).toBe(900);
  });

  it('undefined가 포함되어 있으면 0을 더한다.', () => {
    const selections = [...createMockSelections(), undefined];
    const result = getPriceSum(...selections);

    expect(result).toBe(900);
  });
});
