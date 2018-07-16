#!/bin/bash
# 开发模式下启用crontab
if [ "product" = "$RUN_ENV" ];then
    ln -sf /usr/local/php/lib/php.product.ini /usr/local/php/lib/php.ini
elif [ "test" = "$RUN_ENV" ];then
    ln -sf /usr/local/php/lib/php.test.ini /usr/local/php/lib/php.ini
else
    # 默认值
    RUN_ENV="dev"
    ln -sf /usr/local/php/lib/php.dev.ini /usr/local/php/lib/php.ini
    service crond start
    crontab /data/htdocs/"$APP_NAME"/app/Console/crontab
fi