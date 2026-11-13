#!/bin/sh

echo "Введите IP-адрес или домен:"
read ADDRESS

FAILURES=0

while true
do
    RESULT=$(ping -c 1 -W 1 "$ADDRESS" 2>/dev/null)

    if [ $? -eq 0 ]; then
        FAILURES=0

        TIME=$(echo "$RESULT" | grep 'time=' | cut -d '=' -f 4 | awk '{print $1}')

        if awk "BEGIN {exit !($TIME > 100)}"; then
            echo "Внимание! Время ответа $ADDRESS: ${TIME} мс (больше 100 мс)"
        fi
    else
        FAILURES=$((FAILURES + 1))

        if [ "$FAILURES" -eq 3 ]; then
            echo "Внимание! Три неудачных ping подряд для $ADDRESS"
        fi
    fi

    sleep 1
done
