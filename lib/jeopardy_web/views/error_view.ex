defmodule JeopardyWeb.ErrorView do
  use JeopardyWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{
      status: "error",
      errors: %{detail: Phoenix.Controller.status_message_from_template(template)}
    }
  end

  def render("missing_param.json", %{params: params}) do
    %{
      status: "error",
      error: "Missing Params",
      params: params,
    }
  end
end
