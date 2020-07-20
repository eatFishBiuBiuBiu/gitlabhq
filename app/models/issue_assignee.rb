# frozen_string_literal: true

class IssueAssignee < ApplicationRecord
  belongs_to :issue
  belongs_to :assignee, class_name: "User", foreign_key: :user_id, inverse_of: :issue_assignees

  validates :assignee, uniqueness: { scope: :issue_id }

  scope :in_projects, ->(project_ids) { joins(:issue).where("issues.project_id in (?)", project_ids) }
  scope :on_issues, ->(issue_ids) { where(issue_id: issue_ids) }
end

IssueAssignee.prepend_if_ee('EE::IssueAssignee')
