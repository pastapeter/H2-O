const ROTATE_SENSITIVITY = 15;
const IMG_CNT = 60;

export const calculateImgIdx = (prevX: number, currentX: number, nowImgIdx: number) => {
  const diffX = Math.ceil((prevX - currentX) / ROTATE_SENSITIVITY);
  const nextImgIdx = diffX >= 0 ? (nowImgIdx + diffX) % IMG_CNT : (nowImgIdx + diffX + IMG_CNT) % IMG_CNT;
  return nextImgIdx;
};
