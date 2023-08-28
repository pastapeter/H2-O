export const modelType = {
  powertrains: [
    {
      id: 1,
      name: '디젤 2.2',
      price: 1480000,
      choiceRatio: 48,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비 효율이 우수합니다',
      image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/powertrain/dieselengine2.2.jpg',
      maxOutput: {
        output: 202,
        minRpm: 3800,
        maxRpm: 3800,
      },
      maxTorque: {
        torque: 45,
        minRpm: 1750,
        maxRpm: 2750,
      },
    },
    {
      id: 2,
      name: '가솔린 3.8',
      price: 0,
      choiceRatio: 62,
      description:
        '고마력의 우수한 가속 성능을 확보하여, 넉넉하고 안정감 있는 주행이 가능합니다\n엔진의 진동이 적어 편안하고 조용한 드라이빙 감성을 제공합니다',
      image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/powertrain/gasoline3.8.jpg',
      maxOutput: {
        output: 295,
        minRpm: 6000,
        maxRpm: 6000,
      },
      maxTorque: {
        torque: 36.2,
        minRpm: 5200,
        maxRpm: 5200,
      },
    },
  ],
  bodytypes: [
    {
      id: 1,
      name: '7인승',
      description:
        '기존 8인승 시트(1열 2명, 2열 3명, 3열 3명)에서 2열 가운데 시트를 없애 2열 탑승객의 편의는 물론, 3열 탑승객의 승하차가 편리합니다',
      image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/bodytype/7_seat.jpg',
      price: 0,
      choiceRatio: 45,
    },
    {
      id: 2,
      name: '8인승',
      description: '1열 2명, 2열 3명, 3열 3명이 탑승할 수 있는 구조로, 많은 인원이 탑승할 수 있도록 배려하였습니다',
      image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/bodytype/8_seat.jpg',
      price: 0,
      choiceRatio: 55,
    },
  ],
  drivetrains: [
    {
      id: 1,
      name: '2WD',
      description:
        '엔진에서 전달되는 동력이 전/후륜 바퀴 중 한쪽으로만 전달되어 차량을 움직이는 방식입니다\n차체가 가벼워 연료 효율이 높습니다',
      image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/drivetrain/2wd.png',
      price: 0,
      choiceRatio: 22,
    },
    {
      id: 2,
      name: '4WD',
      description:
        '엔진에서 전달되는 동력이 전/후륜 바퀴 중 한쪽으로만 전달되어 차량을 움직이는 방식입니다\n차체가 가벼워 연료 효율이 높습니다',
      image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/drivetrain/4wd.png',
      price: 2370000,
      choiceRatio: 78,
    },
  ],
};
