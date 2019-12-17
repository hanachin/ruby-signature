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

  def test_reason
    # :break
    begin
      break_in_method.call
      raise
    rescue LocalJumpError => exception
      exception.reason
    end

    # :redo
    begin
      redo_in_method.call
      raise
    rescue LocalJumpError => exception
      exception.reason
    end

    # :return
    begin
      return_from_proc.call
      raise
    rescue LocalJumpError => exception
      exception.reason
    end

    # :noreason
    begin
      no_block
      raise
    rescue LocalJumpError => exception
      exception.reason
    end
  end

  private

  def return_from_proc
    Proc.new { return 42 }
  end

  def break_in_method
    capture { break }
  end

  def redo_in_method
    while true
      return capture { redo }
    end
  end

  def no_block
    yield
  end

  def capture(&b)
    b
  end
end
