import { MaxOutput, MaxTorque } from '@/types/interface';

export const calculateRatios = (maxOutput: MaxOutput, maxTorque: MaxTorque) => {
  const maxOutputPerRpm = maxOutput.output / ((maxOutput.minRpm + maxOutput.maxRpm) / 2);
  const maxTorquePerRpm = maxTorque.torque / ((maxTorque.minRpm + maxTorque.maxRpm) / 2);

  let outputRatio;
  let torqueRatio;
  if (maxOutputPerRpm > maxTorquePerRpm) {
    outputRatio = 1;
    torqueRatio = maxTorquePerRpm / maxOutputPerRpm;
  } else {
    torqueRatio = 1;
    outputRatio = maxOutputPerRpm / maxTorquePerRpm;
  }

  return { outputRatio, torqueRatio };
};
