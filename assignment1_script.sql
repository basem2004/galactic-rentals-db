-- القيام بانشاء قاعدة بيانات واذا كانت موجودة يقوم بتخطي الانشاء
CREATE DATABASE IF NOT EXISTS galactic_rentals;
-- استخدام قاعدة البيانات
USE galactic_rentals;
-- انشاء جدول وفق شروط
CREATE TABLE IF NOT EXISTS rentals(
    -- متغير انتجر للاي دي ليس فارغا وتعينه مفتاح اساسي بحيث لا يتكرر ولا يمون فارغا
	rental_id INT NOT NULL,
    -- تعريف متغير سترينج لاسم الزبون ولا يكون فارغ
    customer VARCHAR(100) NOT NULL,
    -- تعريف متغير سترينج لاسم المنتج ولا يكون فارغ
    costume VARCHAR(100) NOT NULL,
    -- تعريف متغير من نوع تاريخ لتاريخ الاستئجار ولا يمكن ان يكون فارغا
    rent_date DATETIME NOT NULL,
    -- تعريف متغير من نوع تاريخ لتاريخ الارجاع ويمكن ان يكون فارغ ولا يمكن ان يكون اصغر من تاريخ الاستئجار
    return_date DATETIME NULL CHECK (return_date IS NULL OR return_date >rent_date),
    -- تعريف متغير من نوع فلوت لسعر الاستئجار ولا يمكن ان يكون قيمة سالبة
    daily_rate FLOAT NOT NULL CHECK(daily_rate>0),
    -- تاريخ انشاء السجل
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- تاريخ اخر مرة تم تعديل فيها السجل
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- تعيين المفتاح الاساسي
    PRIMARY KEY(rental_id)
); 
-- الادخال عن طريق بلوك انسيرت
INSERT INTO rentals (rental_id,customer, costume, rent_date, return_date, daily_rate)
VALUES (1,'Alice Johnson', 'Imperial Officer', '2025-04-01 10:00:00', '2025-04-03 15:30:00', 25.00),
(2,'Bob Smith', 'Galaxy Explorer', '2025-04-02 9:15:00', '2025-04-05 11:00:00', 30.00),
(3,'Carol Lee', 'Time Traveler', '2025-04-05 14:45:00', '2025-04-06 16:00:00', 20.00),
(4,'Dave Martinez', 'Robot Droid', '2025-04-07 13:00:00', '2025-04-12 13:00:00', 28.50),
(5,'Eva Wang', 'Alien Monarch', '2025-04-10 12:10:00', '2025-04-11 18:20:00', 22.00),
(6,'Frank Davis', 'Imperial Officer', '2025-04-12 8:00:00', '2025-04-15 9:00:00', 25.00),
(7,'Grace Kim', 'Galaxy Explorer', '2025-04-15 10:20:00', '2025-04-17 12:35:00', 30.00),
(8,'Henry Brown', 'Robot Droid', '2025-04-18 11:00:00', '2025-04-19 14:15:00', 28.5),
(9,'Isabel Clark', 'Time Traveler', '2025-04-20 9:30:00', '2025-04-23 10:00:00', 20.00),
(10,'John Doe', 'Alien Monarch', '2025-04-22 14:00:00', NULL, 22);
-- ارجاع كافة اليانات الموجودة في الجدول
SELECT* FROM rentals;
-- تحقق من صحة البيانات المدخلة بحيث يكون تاريخ الاستئجار ليس بالحاضر وتاريخ الارجاع اكبر من تاريح الاستئجار وتاريخ الاستئجار لا يمكن ان يكون فارغ
SELECT* FROM rentals WHERE rent_date < NOW() OR(return_date IS NOT NULL AND return_date < rent_date);
-- التحقق انه لا يوجد سعر بالسالب
SELECT* FROM rentals WHERE (daily_rate < 0);
-- اكثر الازياء طلبا
SELECT costume, COUNT(*) AS times_rented FROM rentals GROUP BY costume ORDER BY times_rented DESC;
-- الاستئجرات المتأخرة
SELECT * FROM rentals WHERE return_date IS NULL AND rent_date < NOW() - INTERVAL 7 DAY;
