import http from 'k6/http';
import {sleep} from 'k6';

export const options = {
    vus: 50,
    duration: '60s',
};
export default function () {
    let url = "http://localhost:8080/car/1/trim";

    http.get(url);

    sleep(1);
}
