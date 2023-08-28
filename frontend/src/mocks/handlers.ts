import { modelType, priceRange, technicalSpecs, trims } from './data';
import { rest } from 'msw';

const BASE_URL = import.meta.env.VITE_API_BASE_URL;

export const handlers = [
  rest.get(`${BASE_URL}/car/:carId/trim`, (_, res, ctx) => {
    return res(ctx.status(200), ctx.json(trims));
  }),
  rest.get(`${BASE_URL}/technical-spec`, (_, res, ctx) => {
    return res(ctx.status(200), ctx.json(technicalSpecs));
  }),
  rest.get(`${BASE_URL}/trim/:trimId/price-range`, (_, res, ctx) => {
    return res(ctx.status(200), ctx.json(priceRange));
  }),
  rest.get(`${BASE_URL}/car/:carId/model-type`, (_, res, ctx) => {
    return res(ctx.status(200), ctx.json(modelType));
  }),
  rest.post(`${BASE_URL}/car`, (_, res, ctx) => {
    return res(
      ctx.status(200),
      ctx.json({
        success: true,
      }),
    );
  }),
];
