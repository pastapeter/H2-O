import { technicalSpecs, trims } from './data';
import { rest } from 'msw';

const BASE_URL = 'http://localhost:5173';

export const handlers = [
  rest.get(`${BASE_URL}/api/car/:carId/trim`, (_, res, ctx) => {
    return res(ctx.status(200), ctx.json(trims));
  }),
  rest.get(`${BASE_URL}/api/technical-spec`, (_, res, ctx) => {
    return res(ctx.status(200), ctx.json(technicalSpecs));
  }),
];
