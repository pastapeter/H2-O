interface Coord {
  x: number;
  y: number;
}

interface getCurrentPricePointParams {
  data: number[];
  currentPrice: number;
  minPrice: number;
  maxPrice: number;
  unit: number;
  element: HTMLDivElement;
}

function getCoordinates(data: number[], element: HTMLDivElement): Coord[] {
  const { width: SVGWidth, height: SVGHeight } = element.getBoundingClientRect();

  const intervalX = SVGWidth / (data.length - 1);
  const max = Math.max(...data);

  return data.reduce<Coord[]>((acc, curr, idx) => [...acc, { x: idx * intervalX, y: (curr / max) * SVGHeight }], []);
}

function getPathLAttribute(data: number[], element: HTMLDivElement) {
  const coords = getCoordinates(data, element);

  const d = coords.reduce((acc, curr, idx) => {
    const { x, y } = curr;
    const isFirst = idx === 0;

    if (isFirst) return `M ${x} ${y}`;

    const { x: cpsX, y: cpsY } = getControlPoint(coords[idx - 2], coords[idx - 1], curr);
    const { x: cpeX, y: cpeY } = getControlPoint(coords[idx - 1], curr, coords[idx + 1], true);

    return `${acc} C ${cpsX} ${cpsY} ${cpeX} ${cpeY} ${x} ${y}`;
  }, '');

  return d;
}

function getOpposedLine(pointA: Coord, pointB: Coord) {
  const xLength = pointB.x - pointA.x;
  const yLength = pointB.y - pointA.y;

  const zLength = Math.sqrt(Math.pow(xLength, 2) + Math.pow(yLength, 2));
  const angle = Math.atan2(yLength, xLength);

  return { length: zLength, angle } as const;
}

function getControlPoint(prev: Coord, curr: Coord, next: Coord, isEndPoint?: boolean): Coord {
  const _prev = prev || curr;
  const _next = next || curr;

  const smoothDegree = 0.25;

  const o = getOpposedLine(_prev, _next);

  const angle = o.angle + (isEndPoint ? Math.PI : 0);
  const length = o.length * smoothDegree;

  const x = curr.x + Math.cos(angle) * length;
  const y = curr.y + Math.sin(angle) * length;

  return { x, y };
}

function getCurrentPricePoint({
  data,
  currentPrice,
  minPrice,
  maxPrice,
  unit,
  element,
}: getCurrentPricePointParams): Coord {
  const { width: SVGWidth, height: SVGHeight } = element.getBoundingClientRect();

  const intervalX = SVGWidth / (data.length - 1);
  const max = Math.max(...data);

  let current = minPrice;
  for (let idx = 0; current <= maxPrice; idx++) {
    if (currentPrice >= current && currentPrice <= current + unit) {
      return { x: idx * intervalX, y: (data[idx] / max) * SVGHeight };
    }

    current += unit;
  }

  return { x: SVGWidth - intervalX, y: (currentPrice / max) * SVGHeight };
}

export { getPathLAttribute, getCurrentPricePoint };
