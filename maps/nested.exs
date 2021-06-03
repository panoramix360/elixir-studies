defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end


defmodule Main do
  def main do
    report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}

    IO.inspect report

    IO.inspect report.owner.company

    report = %BugReport{ report | owner: %Customer{ report.owner | company: "PragProg" } }

    IO.inspect report

    report2 = put_in(report.owner.company, "PragProg2")

    IO.inspect report2

    report3 = update_in(report.owner.name, &("Mr. " <> &1))

    IO.inspect report3

    IO.inspect report4 = %{ owner: %{ name: "Dave", company: "Pragmatic" } }

    IO.inspect put_in(report4[:owner][:company], "PragProg")
  end
end

Main.main
