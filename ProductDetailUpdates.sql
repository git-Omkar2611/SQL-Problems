UPDATE existing
SET price = updated.price , product_name = updated.product_name
from products existing
INNER JOIN products_stg updated
on existing.product_id = updated.product_ID