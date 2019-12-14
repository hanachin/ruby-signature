require_relative "test_helper"

class LocalJumpErrorTest < StdlibTest
  target LocalJumpError
  using hook.refinement

  def test_exit_value
    begin
      return_from_proc.call
      raise
    rescue LocalJumpError => exception
      exception.exit_value
    end
  end

  private

  def return_from_proc
    Proc.new { return 42 }
  end
end
