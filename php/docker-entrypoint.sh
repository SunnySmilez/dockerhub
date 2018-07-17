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
    if [ "php-fpm" = "$1" ]; then
        service crond start
        crontab /data/htdocs/"$APP_NAME"/bin/crontab
    fi
fi

if [ "php-fpm" = "$1" ]; then
    touch /tmp/php.log && chmod 666 /tmp/php.log
    nohup tail -f /tmp/php.log &
    exec "$@"
elif [ "php" = "$1" ];then
    exec "$@"
elif [ "phpunit" = "$1" ];then
    exec "$@"
else
    echo "error : run mode not in php-fpm,php,phpunit"
fi