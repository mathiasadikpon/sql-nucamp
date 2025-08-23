-- Select photographs
SELECT *
FROM moma_works
WHERE classification = 'Photograph';

-- Ignore entries with invalid width or height
SELECT *
FROM moma_works
WHERE classification = 'Photograph'
  AND width > 0
  AND height > 0;