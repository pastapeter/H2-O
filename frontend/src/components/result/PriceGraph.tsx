import { useEffect, useRef } from 'react';
import styled from '@emotion/styled';

type Coord = [number, number];
const mocks = [0, 12, 30, 40, 50, 60, 10, 5, 20, 35, 40, 45, 20, 12, 0];

function PriceGraph() {
  const containerRef = useRef<HTMLDivElement | null>(null);
  const svgRef = useRef<SVGSVGElement | null>(null);
  const pathRef = useRef<SVGPathElement | null>(null);
  const markerRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    if (!containerRef.current || !svgRef.current || !pathRef.current) return;
    const { width: SVGWidth, height: SVGHeight } = containerRef.current.getBoundingClientRect();

    const currentPoint = getCurrentPricePoint(mocks, containerRef.current);
    markerRef.current?.style.setProperty('left', `${currentPoint[0]}px`);
    markerRef.current?.style.setProperty('bottom', `${currentPoint[1]}px`);

    const d = getPathLAttribute(mocks, containerRef.current);

    const svg = svgRef.current;
    const path = pathRef.current;

    svg.setAttribute('viewbox', `0 0 ${SVGWidth} ${SVGHeight}`);
    svg.setAttribute('width', `100%`);
    svg.setAttribute('height', `${SVGHeight + 10}`);
    svg.setAttribute('transform', 'scale(1, -1)');
    path.setAttribute('d', d);
    path.setAttribute('fill', 'none');
    path.setAttribute('stroke', '#DADCDD');
    path.setAttribute('stroke-width', '4');
  }, [containerRef.current]);

  return (
    <Container ref={containerRef}>
      <svg ref={svgRef} xmlns='http://www.w3.org/2000/svg'>
        <path ref={pathRef} />
      </svg>
      <Circle ref={markerRef}>
        <div />
      </Circle>
    </Container>
  );
}

export default PriceGraph;

const Container = styled.div`
  position: relative;
  width: 100%;
  height: 120px;
  margin-top: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
`;

function getCoordinates(data: number[], element: HTMLDivElement): Coord[] {
  const { width: SVGWidth, height: SVGHeight } = element.getBoundingClientRect();

  const intervalX = SVGWidth / (data.length - 1);
  const max = Math.max(...data);

  return data.reduce<Coord[]>((acc, curr, idx) => [...acc, [idx * intervalX, (curr / max) * SVGHeight]], []);
}

function getPathLAttribute(data: number[], element: HTMLDivElement) {
  const coords = getCoordinates(data, element);

  const d = coords.reduce((acc, curr, idx) => {
    const isFirst = idx === 0;

    if (isFirst) return `M ${curr[0]} ${curr[1]}`;

    const [cpsX, cpsY] = getControlPoint(coords[idx - 2], coords[idx - 1], curr);
    const [cpeX, cpeY] = getControlPoint(coords[idx - 1], curr, coords[idx + 1], true);

    return `${acc} C ${cpsX} ${cpsY} ${cpeX} ${cpeY} ${curr[0]} ${curr[1]}`;
  }, '');

  return d;
}

function getOpposedLine(pointA: Coord, pointB: Coord) {
  const xLength = pointB[0] - pointA[0];
  const yLength = pointB[1] - pointA[1];

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

  const x = curr[0] + Math.cos(angle) * length;
  const y = curr[1] + Math.sin(angle) * length;

  return [x, y];
}

function getCurrentPricePoint(data: number[], element: HTMLDivElement) {
  const { width: SVGWidth, height: SVGHeight } = element.getBoundingClientRect();

  const intervalX = SVGWidth / (data.length - 1);
  const max = Math.max(...data);

  const currentPrice = 45000;
  for (let i = 0; i < data.length * 10000; i += 10000) {
    if (currentPrice >= i && currentPrice <= i + 10000) {
      const idx = i / 10000;
      return [idx * intervalX, (data[idx] / max) * SVGHeight];
    }
  }

  return [SVGWidth - intervalX, (currentPrice / max) * SVGHeight];
}

const Circle = styled.div`
  position: absolute;
  width: 22px;
  height: 22px;
  transform: translateY(50%);
  border-radius: 50%;
  border: 2px solid ${({ theme }) => theme.colors.activeBlue2};

  & > div {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background-color: ${({ theme }) => theme.colors.activeBlue2};
  }

  &::after {
    content: '내 견적';
    position: absolute;
    left: 100%;
    top: 50%;
    transform: translate(10px, -50%);
    color: ${({ theme }) => theme.colors.activeBlue2};
    white-space: nowrap;
  }
`;
