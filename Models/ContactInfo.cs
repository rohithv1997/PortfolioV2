namespace PortfolioV2.Models;

public record ContactInfo
{
    public required string Email { get; init; }
    public required string Location { get; init; }
    public required string LinkedIn { get; init; }
    public required string Github { get; init; }
    public required string Resume { get; init; }
    public string EmailLink => $"mailto:{Email}";
}