"""add customers date_of_birth

Revision ID: 40f7770b3fa1
Revises: e87b1dd1164f
Create Date: 2025-08-13 14:16:58.982495

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '40f7770b3fa1'
down_revision: Union[str, Sequence[str], None] = 'e87b1dd1164f'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
