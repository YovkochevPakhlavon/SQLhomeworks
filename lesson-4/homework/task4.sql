-- ## Task 4
-- - Order letters but 'b' must be first/last
-- - Order letters but 'b' must be 3rd (Optional):

create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

--Order letters but 'b' must be first
SELECT letter
FROM letters
ORDER BY 
    CASE 
        WHEN letter = 'b' THEN 0  -- 'b' comes first
        ELSE 1 
    END,
    letter; 

--Order letters but 'b' must be last
SELECT letter
FROM letters
ORDER BY 
    CASE 
        WHEN letter = 'b' THEN 1  -- 'b' comes last
        ELSE 0 
    END,
    letter; 

--Order letters but 'b' must be 3rd
SELECT letter
FROM letters
ORDER BY 
    CASE 
        WHEN letter = 'b' THEN 2  -- 'b' comes 3rd
        WHEN letter = 'a' THEN 1 
        ELSE 3
    END,
    letter; 
