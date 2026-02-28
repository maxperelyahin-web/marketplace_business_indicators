--Сбор данных о пользователях, которые зарегистрировались в 2024 году.
--JSON-значения представить в виде отдельных столбцов для необходимых параметров.
SELECT user_id, 
    registration_date, 
    user_params ->> 'age' AS age,
    user_params ->> 'gender' AS gender,
    user_params ->> 'region' AS region,
    user_params ->> 'acq_channel' AS acq_channel,
    user_params ->> 'buyer_segment' AS buyer_segment,
    DATE_TRUNC('week', users.registration_date)::date AS cohort_week,
    DATE_TRUNC('month', users.registration_date)::date AS cohort_month
FROM pa_graduate.users
WHERE EXTRACT(YEAR FROM users.registration_date) = 2024
LIMIT 100

--Сбор данных о событиях, которые произошли в 2024 году
SELECT event_id, 
    user_id, 
    timestamp AS event_date,
    event_type,
    event_params ->> 'os' AS os,
    event_params ->> 'device' AS device,
    product_name,
    DATE_TRUNC('week', timestamp)::date AS event_week,
    DATE_TRUNC('month', timestamp)::date AS event_month
FROM pa_graduate.events
LEFT JOIN pa_graduate.product_dict ON events.product_id = product_dict.product_id
WHERE EXTRACT(YEAR FROM timestamp) = 2024
ORDER BY event_date ASC
LIMIT 100

--Сбор данных о заказах, которые были сделаны в 2024 году. 
SELECT order_id, 
    user_id, 
    order_date,
    product_name,
    quantity,
    unit_price,
    total_price,
    category_name,
    DATE_TRUNC('week', order_date)::date AS order_week,
    DATE_TRUNC('month', order_date)::date AS order_month
FROM pa_graduate.orders
LEFT JOIN pa_graduate.product_dict ON orders.product_id = product_dict.product_id
WHERE EXTRACT(YEAR FROM order_date) = 2024
ORDER BY order_date ASC
LIMIT 100