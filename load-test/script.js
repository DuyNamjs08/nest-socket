

import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
    vus: 100,            // số lượng virtual users
    duration: '50s',    // thời gian test
};

export default function () {
    const url = 'http://localhost:8086/video-ai/generate'; // đổi port NestJS của bạn
    const payload = JSON.stringify({ prompt: 'hello bạn' });

    const params = {
        headers: {
            'Content-Type': 'application/json',
        },
    };

    let res = http.post(url, payload, params);

    check(res, {
        'status is 2xx': (r) => r.status >= 200 && r.status < 300,
        'returned queued': (r) => r.json().data?.status === 'queued',
    });

    sleep(1);
}
