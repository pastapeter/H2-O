import http from 'k6/http';
import {sleep} from 'k6';

export const options = {
    vus: 50,
    duration: '60s',
};
export default function () {
    let url = "https://api.h2-cartalog.site/quotation/similar";

    let payload = JSON.stringify({
        "carId": 1,
        "externalColorId": 1,
        "internalColorId": 1,
        "modelTypeIds": {
            "bodytypeId": 1,
            "drivetrainId": 1,
            "powertrainId": 1
        },
        "optionIds": [],
        "packageIds": [],
        "trimId": 2
    });

    let params = {
        headers: {
            "Content-Type": "application/json",
        },
    };

    http.post(url, payload, params);
    sleep(1);
}
