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

-- Set recommended frame area
WITH frames AS (
    SELECT
    CEIL(width) + 2 AS frame_width,
    CEIL(height) + 4 AS frame_height
    FROM moma_works
    WHERE classification = 'Photograph' AND width > 0 AND height > 0
)
SELECT
frame_width,
frame_height,
frame_width * frame_height AS frame_area
FROM frames;

-- Count number of frames required per size
WITH frames AS (
    SELECT
    CEIL(width) + 2 AS frame_width,
    CEIL(height) + 4 AS frame_height
    FROM moma_works
    WHERE classification = 'Photograph' AND width > 0 AND height > 0
)
SELECT
COUNT(*),
frame_width,
frame_height,
frame_width * frame_height AS frame_area
FROM frames
GROUP BY frame_width, frame_height, frame_area;

-- Insert artist information
INSERT INTO moma_artists (info) VALUES (
    json_object('{display_name, Ablade Glover, nationality, Ghanaian}')
);
INSERT INTO moma_artists (info) VALUES (
    json_object('{{display_name, Ablade Glover}, {nationality, Ghanaian}}')
);
INSERT INTO moma_artists (info) VALUES (
    json_object('{display_name, nationality}', '{Ablade Glover, Ghanaian}')
);