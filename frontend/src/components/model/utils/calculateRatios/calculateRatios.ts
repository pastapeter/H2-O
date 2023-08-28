import { MaxOutput, MaxTorque, PowerTrain } from '@/types/response';

export const calculateRatios = (powertrains: PowerTrain[], maxOutput: MaxOutput, maxTorque: MaxTorque) => {
  const maxOutputRatio = Math.max(
    ...powertrains.map(({ maxOutput }) => maxOutput.output / ((maxOutput.minRpm + maxOutput.maxRpm) / 2)),
  );
  const maxTorqueRatio = Math.max(
    ...powertrains.map(({ maxTorque }) => maxTorque.torque / ((maxTorque.minRpm + maxTorque.maxRpm) / 2)),
  );

  const outputPerRpm = maxOutput.output / ((maxOutput.minRpm + maxOutput.maxRpm) / 2);
  const torquePerRpm = maxTorque.torque / ((maxTorque.minRpm + maxTorque.maxRpm) / 2);

  const outputRatio = outputPerRpm / maxOutputRatio;
  const torqueRatio = torquePerRpm / maxTorqueRatio;

  return { outputRatio, torqueRatio };
};
