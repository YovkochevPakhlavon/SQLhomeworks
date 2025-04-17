CREATE FUNCTION Calendar(@date DATE)
RETURNS @TableCalendar TABLE (WeekNumber INT, Sunday INT, Monday INT, Tuesday INT, Wednesday INT, Thursday INT, Friday INT, Saturday INT)
AS
BEGIN
    DECLARE @FirstDay DATE = DATEFROMPARTS(YEAR(@date),MONTH(@date), 1);
    DECLARE @LastDay DATE = EOMONTH(@date);
    DECLARE @CurrentDay DATE = @FirstDay;
    DECLARE @CurrentWeek INT = 1;

    INSERT INTO @TableCalendar (WeekNumber) VALUES (@CurrentWeek);

    WHILE @CurrentDay <= @LastDay
    BEGIN
        DECLARE @WeekDay NVARCHAR(10) = DATENAME(WEEKDAY, @CurrentDay);

        IF @WeekDay = 'Sunday'
            UPDATE @TableCalendar SET Sunday = DAY(@CurrentDay) WHERE WeekNumber = @CurrentWeek;
        ELSE IF @WeekDay = 'Monday'
            UPDATE @TableCalendar SET Monday = DAY(@CurrentDay) WHERE WeekNumber = @CurrentWeek;  
        ELSE IF @WeekDay = 'Tuesday'
            UPDATE @TableCalendar SET Tuesday = DAY(@CurrentDay) WHERE WeekNumber = @CurrentWeek;                      
        ELSE IF @WeekDay = 'Wednesday'
            UPDATE @TableCalendar SET Wednesday = DAY(@CurrentDay) WHERE WeekNumber = @CurrentWeek;  
        ELSE IF @WeekDay = 'Thursday'
            UPDATE @TableCalendar SET Thursday = DAY(@CurrentDay) WHERE WeekNumber = @CurrentWeek;
        ELSE IF @WeekDay = 'Friday'
            UPDATE @TableCalendar SET Friday = DAY(@CurrentDay) WHERE WeekNumber = @CurrentWeek;             
        ELSE IF @WeekDay = 'Saturday'
        BEGIN
            UPDATE @TableCalendar SET Saturday = DAY(@CurrentDay) WHERE WeekNumber = @CurrentWeek;
            SET @CurrentWeek = @CurrentWeek + 1;
            INSERT INTO @TableCalendar (WeekNumber) VALUES (@CurrentWeek);
        END

        SET @CurrentDay = DATEADD(DAY, 1, @CurrentDay);
    END;

    RETURN;
END;



