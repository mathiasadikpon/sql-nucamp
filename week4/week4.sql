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

-- Set recommended frame width and height
SELECT
CEIL(width) + 2 AS frame_width,
CEIL(height) + 4 AS frame_height
FROM moma_works
WHERE classification = 'Photograph' AND width > 0 AND height > 0;