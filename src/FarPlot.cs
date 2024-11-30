using ScottPlot.WinForms;
using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ScottPlot;

/// <summary>
/// Extends <see cref="Plot"/> with helpers for showing the plot in a form.
/// </summary>
public class FarPlot : Plot
{
    readonly CancellationTokenSource _tokenSource = new();
    private string _formTitle;
    FormsPlot _plot;
    Form _form;
    System.Windows.Forms.Timer _timer;

    /// <summary>
    /// Gets or sets the form title.
    /// </summary>
    public string FormTitle
    {
        get => _formTitle;
        set
        {
            _formTitle = value;
            if (_form is {})
                _form.Text = _formTitle;
        }
    }

    /// <summary>
    /// Gets or sets the form width.
    /// </summary>
    public int FormWidth { get; set; } = 800;

    /// <summary>
    /// Gets or sets the form height.
    /// </summary>
    public int FormHeight { get; set; } = 600;

    /// <summary>
    ///
    /// </summary>
    public int FormInterval { get; set; }

    /// <summary>
    ///
    /// </summary>
    public Action FormUpdate { get; set; }

    /// <summary>
    /// Gets the cancellation token for live plot tasks.
    /// </summary>
    public CancellationToken CancellationToken { get; }

    /// <summary>
    /// Gets true if the form is cancelling.
    /// </summary>
    public bool IsCancellationRequested => CancellationToken.IsCancellationRequested;

    /// <summary>
    /// Creates a new plot for showing in a form.
    /// </summary>
    /// <param name="formTitle">Specifies the form window title.</param>
    public FarPlot(string formTitle = null)
    {
        CancellationToken = _tokenSource.Token;
        FormTitle = formTitle;
    }

    /// <summary>
    /// Calls <see cref="Show()"/> and delays for the specified number of milliseconds.
    /// </summary>
    public Task ShowAsync(int millisecondsDelay)
    {
        Show();
        return Task.Delay(millisecondsDelay, CancellationToken);
    }

    /// <summary>
    /// Calls <see cref="Show()"/> and blocks the current thread for the specified number of milliseconds.
    /// In async contexts consider using <see cref="ShowAsync"/> instead.
    /// </summary>
    /// <param name="millisecondsWait">The number of milliseconds to wait or -1 to wait indefinitely.</param>
    public void Show(int millisecondsWait)
    {
        Show();

        //! valid 0 case: `$plot.Show($(if ($Wait) {-1} else {0}))`
        if (millisecondsWait != 0)
            CancellationToken.WaitHandle.WaitOne(millisecondsWait);
    }

    /// <summary>
    /// Shows this plot in a form or renders the shown form after plot changes.
    /// </summary>
    /// <remarks>
    /// This method shows the form and returns immediately.
    /// In order to block the current thread until the form is closed call <see cref="Show(int)"/> with -1.
    /// </remarks>
    public void Show()
    {
        if (_plot is null)
        {
            var thread = new Thread(Start)
            {
                Name = "Plot thread.",
                IsBackground = true
            };
            thread.SetApartmentState(ApartmentState.STA);
            thread.Start();
        }
        else
        {
            if (CancellationToken.IsCancellationRequested)
                return;

            try
            {
                // Use `Invoke()` to avoid 'Cross-thread operation not valid: Control 'pictureBox1' accessed from a thread other than the thread it was created on.'
                //_form.Invoke(() => _plot.Show()); //rk-0
                _form.Invoke(_plot.Refresh); //rk-0
            }
            catch (InvalidOperationException ex)
            {
                // "Object is currently in use elsewhere." was seen and silenced before using above `Invoke()`.
                // This `catch` might be not needed anymore. But keep it for now.
                Trace.WriteLine($"ScottPlot error: {ex.Message}");
            }
        }
    }

    void Update(object sender, EventArgs e)
    {
        _timer.Stop();
        try
        {
            FormUpdate();
            _plot.Refresh();
        }
        finally
        {
            _timer.Start();
        }
    }

    /// <summary>
    /// See <see cref="FormsPlotViewer.CreateForm"/>.
    /// </summary>
    void Start()
    {
        #region ScottPlot.WinForms.FormsPlotViewer.CreateForm
        _plot = new FormsPlot
        {
            Dock = DockStyle.Fill
        };
        _plot.Reset(this);
        _form = new Form
        {
            StartPosition = FormStartPosition.CenterScreen,
            Width = FormWidth,
            Height = FormHeight,
            Text = FormTitle,
            Controls = { _plot }
        };
        #endregion

        _form.Load += (s, e) =>
        {
            _form.Activate();
        };

        _plot.KeyDown += (s, e) =>
        {
            if (e.KeyCode == Keys.Escape)
            {
                _tokenSource.Cancel();
                _form.Close();
            }
        };

        if (FormInterval > 0 && FormUpdate is { })
        {
            FormUpdate();

            _timer = new System.Windows.Forms.Timer { Interval = FormInterval };
            _timer.Tick += Update;
            _timer.Start();
        }

        try
        {
            _form.ShowDialog();
        }
        finally
        {
            _tokenSource.Cancel();

            _timer?.Dispose();
            _form.Dispose();
            _plot.Dispose();
        }
    }
}
