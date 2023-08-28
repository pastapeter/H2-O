import {
  getLocalStorageItem,
  hasLocalStorageItem,
  removeLocalStorageItem,
  setLocalStorageItem,
} from '@/utils/localStorage';

describe('getLocalStorageItem 유틸 함수 테스트', () => {
  afterEach(() => {
    window.localStorage.clear();
  });

  it('localStorage에 저장된 값이 없으면 null을 반환한다.', () => {
    const item = getLocalStorageItem('test');
    expect(item).toBeNull();
  });

  it('localStorage에 저장된 값이 있으면 해당 값을 반환한다.', () => {
    window.localStorage.setItem('test', 'test');
    const item = getLocalStorageItem('test');
    expect(item).toBe('test');
  });
});

describe('setLocalStorageItem 유틸 함수 테스트', () => {
  afterEach(() => {
    window.localStorage.clear();
  });

  it('key와 value를 인자로 받아 localStorage에 저장한다.', () => {
    setLocalStorageItem('test', 'test');
    const item = window.localStorage.getItem('test');
    expect(item).toBe('test');
  });
});

describe('removeLocalStorageItem 유틸 함수 테스트', () => {
  afterEach(() => {
    window.localStorage.clear();
  });

  it('key를 인자로 받아 localStoraged에서 해당 key에 해당하는 데이터를 삭제한다.', () => {
    window.localStorage.setItem('test', 'test');

    let item = window.localStorage.getItem('test');
    expect(item).toBe('test');

    removeLocalStorageItem('test');
    item = window.localStorage.getItem('test');
    expect(item).toBeNull();
  });
});

describe('hasLocalStorageItem 유틸 함수 테스트', () => {
  afterEach(() => {
    window.localStorage.clear();
  });

  it('localStorage에 전달받은 key에 해당하는 value가 없으면 false를 반환한다.', () => {
    expect(hasLocalStorageItem('test')).toBeFalsy();
  });

  it('localStorage에 전달받은 key에 해당하는 value가 있으면 true를 반환한다.', () => {
    window.localStorage.setItem('test', 'test');
    expect(hasLocalStorageItem('test')).toBeTruthy();
  });
});
