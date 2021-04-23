# livechat-laravel-vue

---

### Laravel Practice

> 코지 코더님의 동영상을 참고하여 Docker 환경으로 똑같이 구축해보기 링크: https://youtu.be/8nNZCDbYUJQ
> 2019년 영상으로 현재 상용화 중인 버전과 차이점이 있을 수 있고 영상을 참고하여 따라하더라도 에러를 자주 접할 수도 있음
> 진행과정에서 에러 발생 및 처리 방법은 하단에 기록

---

### Skills

-   DevOps

    -   Docker
    -   Mysql
    -   Nginx

-   Frontend

    -   HTML5, CSS, JS
    -   Tailwind CSS
    -   Vue.js

-   Backend

    -   PHP, Laravel

---

### Docker 실행 방법

```bash
실행: docker-compose up -d --build
종료: docker-compose down -v
```

---

### ErrorList

-   mix not found 에러 발생 시
    -   package.json 파일 수정

```
"scripts": {
    "dev": "npm run development",
    "development": "cross-env NODE_ENV=development node_modules/webpack/bin/webpack.js --progress --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js",
    "watch": "npm run development -- --watch",
    "watch-poll": "npm run watch -- --watch-poll",
    "hot": "cross-env NODE_ENV=development node_modules/webpack-dev-server/bin/webpack-dev-server.js --inline --hot --disable-host-check --config=node_modules/laravel-mix/setup/webpack.config.js",
    "prod": "npm run production",
    "production": "cross-env NODE_ENV=production node_modules/webpack/bin/webpack.js --no-progress --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js"
}
```
