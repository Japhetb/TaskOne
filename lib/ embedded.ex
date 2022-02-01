defprotocol Protocals do
def type(value)
end

defimpl Protocals, for: BitString  do
  @spec type(binary) :: <<_::48>>
  def type(_value), do: "String"
end

defimpl Protocals, for: Map  do
  def type(_value), do: "Map"
end

defimpl Protocals, for: Integer do
  def type(_value), do: "Integer"
end
