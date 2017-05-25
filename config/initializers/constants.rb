# frozen_string_literal: true

NEIGHBOURS = YAML.load_file("#{Rails.root}/db/data/neighbouring_positions.yml")
PATTERNS = YAML.load_file("#{Rails.root}/db/data/patterns.yml")
GRID_SIZE = 12
