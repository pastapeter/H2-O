import { api } from '@/utils/fetch';

describe('fetch api 유틸 함수 테스트', () => {
  // mock api path
  const GET_API_URL = '/car/:carId/trim';
  const POST_API_URL = '/car';

  describe('api의 get 함수 테스트', () => {
    it('api의 get 함수가 성공하면 응답 데이터를 반환한다.', async () => {
      const response = await api.get(GET_API_URL);

      expect(response).toBeTruthy();
    });

    it('api의 get 함수가 실패하면 에러를 반환한다.', async () => {
      await expect(() => api.get('/will-fail')).rejects.toThrowError(/failed to fetch/i);
    });
  });

  describe('api의 post 함수 테스트', () => {
    const body = JSON.stringify({ name: 'test' });
    it('api의 post 함수가 성공하면 응답 데이터를 반환한다.', async () => {
      const response = await api.post(POST_API_URL, body);

      expect(response).toBeTruthy();
    });

    it('api의 get 함수가 실패하면 에러를 반환한다.', async () => {
      await expect(() => api.post('/will-fail', body)).rejects.toThrowError(/failed to fetch/i);
    });
  });
});
