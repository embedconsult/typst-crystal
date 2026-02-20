module Typst
  VERSION = "0.1.0"

  module Runner
    extend self

    def run
      rust_binary = File.expand_path("../bin/typst-rust", __DIR__)

      if executable?(rust_binary)
        exec_with_args(rust_binary)
      else
        STDERR.puts "typst-rust binary was not found at #{rust_binary}; falling back to cargo run."
        run_through_cargo
      end
    end

    private def executable?(path : String)
      return false unless File.exists?(path)

      perm = File.info(path).permissions
      perm.owner_execute? || perm.group_execute? || perm.other_execute?
    rescue
      false
    end

    private def exec_with_args(binary : String)
      process = Process.new(binary, ARGV, input: Process::Redirect::Inherit, output: Process::Redirect::Inherit, error: Process::Redirect::Inherit)
      exit process.wait.exit_code
    end

    private def run_through_cargo
      command = ["cargo", "run", "--release", "--package", "typst-cli", "--"] + ARGV
      process = Process.new(command[0], command[1..], input: Process::Redirect::Inherit, output: Process::Redirect::Inherit, error: Process::Redirect::Inherit)
      exit process.wait.exit_code
    rescue ex
      STDERR.puts "failed to launch typst via cargo: #{ex.message}"
      exit 1
    end
  end
end

Typst::Runner.run
